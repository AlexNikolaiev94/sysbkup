# sysbkup
A collection of simple scripts using bsdtar to create full system backups


| :exclamation: :zap:       Ignore at your own risk!   |
|------------------------------------------------------|

This is a proof of concept tool **ENTIRELY** not intended for use with any production, or personal, or any other live system. Relying on it for creating real-life system backups may result in losing your OS - quality of backups is ABSOLUTELY not warranted!

### Description

Some proof of concept scripts automating the full system backup process using bsdtar described in https://wiki.archlinux.org/title/Full_system_backup_with_tar - attempted to be distribution-agnostic though. Not tested to a full capacity yet - intermediate tests on a local filesystem with local directories using sudo (without LiveCD and chroot) were carried out.
It may see some future updates and upgrades like packaging of some sorts or an installation script, but still it is absolutely not to be considered a professional backup tool for production use, and is better to be treated as already abandoned.

### Usage

1. Clone the repository anywhere
2. Using sudo or a root account copy the contents somewhere like `/usr/bin/sysbkup`
3. (OPTIONAL): Add the directory to your `$PATH`
4. Make the sysbkup script executable
5. Run `sysbkup --genconf` to generate some configuration files to be used during the backup process
6. If you want to try it out and create a backup - first, get some **real** backup, then boot from LiveCD of your distribution, mount the root partition of your filesystem, chroot, mount the remaining partitions if there are any
7. Run `sysbkup --backup`. It may take a while depending on your machine; The output can be found at /var/log/sysbkup-$DATE.log 
8. Feel free to tinker but do take care
