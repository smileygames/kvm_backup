# kvm_backup
VM環境のオフラインバックアップスクリプト

---

### **⏬ このスクリプトの動作**
1. **起動しているVMをシャットダウン**（30秒待機、残り秒数を表示）
2. **シャットダウンが間に合わないVMを強制停止**
3. **全VMの設定ファイルをバックアップ**
4. **ディスクイメージを `rsync` でコピー**
5. **元々起動していたVMを再起動**
6. **完了メッセージを表示**

---

### 起動方法
/home/user/
以下にkvm_backup.shをアップロード
sudo chmod 600 /home/user/kvm_backup.sh
sudo time sh ./kvm_backup.sh

### リストア方法(VM名がalma9-vmの場合)
cp -p /backup/libvirt/qemu/alma9-vm.xml /etc/libvirt/qemu/alma9-vm.xml
cp -p /backup/libvirt/images/alma9-vm.img /var/lib/libvirt/images/alma9-vm.img
virsh define /etc/libvirt/qemu/alma9-inss.xml
