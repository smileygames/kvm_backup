#!/bin/bash

BACKUP_DIR="/backup/libvirt"

mkdir -p "$BACKUP_DIR/images" "$BACKUP_DIR/qemu"

# **最初に稼働していたゲストのリストを保存**
running_vms=$(virsh list --name)

# **すべてのVMを通常シャットダウン**
if [ -n "$running_vms" ]; then
    for vm in $running_vms; do
        virsh shutdown "$vm"
    done

    # **シャットダウンを最大30秒待機**
    SECONDS_LEFT=30
    while [ -n "$(virsh list --name)" ] && [ $SECONDS_LEFT -gt 0 ]; do
        printf "\rWaiting: %2d seconds remaining..." "$SECONDS_LEFT"
        sleep 1
        ((SECONDS_LEFT--))
    done

    # **まだ動いているVMを強制停止**
    remaining_vms=$(virsh list --name)
    if [ -n "$remaining_vms" ]; then
        for vm in $remaining_vms; do
            virsh destroy "$vm"
        done
    fi
fi

# **すべてのVMの設定ファイルをコピー**
for vm in $(virsh list --all --name); do
    virsh dumpxml "$vm" > "$BACKUP_DIR/qemu/$vm.xml"
done

# **ディスクイメージをバックアップ**
rsync -ah --progress /var/lib/libvirt/images/ "$BACKUP_DIR/images/"

# **最初に稼働していたゲストを再起動**
if [ -n "$running_vms" ]; then
    for vm in $running_vms; do
        virsh start "$vm"
    done
fi

echo "✅  Backup complete. Running VMs have been restarted."

