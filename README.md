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
1. /home/user/ 以下にkvm_backup.shをアップロード
2. sudo chmod 600 kvm_backup.sh
3. sudo time sh ./kvm_backup.sh

### リストア方法(VM名がalma9-vmの場合)
1. cp -p /backup/libvirt/qemu/alma9-vm.xml /etc/libvirt/qemu/alma9-vm.xml
2. cp -p /backup/libvirt/images/alma9-vm.img /var/lib/libvirt/images/alma9-vm.img
3. virsh define /etc/libvirt/qemu/alma9-inss.xml

今回は完全に自分の環境用のスクリプトなので、環境次第ではうまく動かない可能性があります。
もし使うなら、あくまで参考用にお使いください。
上手く動かなかった場合はご自身で修正するなりしてみてね～。
