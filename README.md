# Linux VM Installer

`scripts/vm/build.sh $TEMPLATE_NAME` builds a new VM from a template.

## Template

Templates are described by a `vm-templates/$TEMPLATE_NAME` directory:
- `config.env` set global options (defaults are defined in `scripts/core/config.env`).
- .

## Recipes

- `cmd $CMD $ARGS...` runs the command on the VM.
- `upload $FILE $DEST` upload a file into the VM.

TODO:
- screenrc
- tldr
- htop/btop
- sudo
- ssh

## Steps

Internally `build` uses:
1. `scripts/vm/create.sh $TEMPLATE_NAME`
1. `scripts/vm/preseed.sh`
1. `scripts/vm/install-os.sh $TEMPLATE_NAME`
1. `scripts/vm/configure.sh $TEMPLATE_NAME`

### `install-os`

Note: `install-os` will not work on an already installed VM.

Note : Alt+F4 to visualize logs during installation (Alt+F1 to go back).

`install-os` uses:
- `postinstall.sh` to preconfigure the VM (enables SSH root login for the `configure` step).

At the end of this step, a `base-install` snapshot is created, enabling to reconfigure a VM without recreating it.

### `configure`

(Re-)configure the VM starting from the `base-install` snapshot. At the end of this step, a `fresh-install` snapshot is created.

## iso

We provide scripts to personalize ISO files. We do not recommend using it as recreating the ISO file and reinstalling the VM takes time.

1. `scripts/iso/mount $ISO_FILE $ISO_DIR`: 
1. modify files in `$ISO_DIR`.
1. `scripts/iso/save $ISO_DIR $ISO_FILE`: write changes into a new ISO file.
1. `scripts/iso/umount $ISO_DIR`

## OLD

Proxy install :

```bash
echo 'http_proxy="$http_proxy"' >> /target/etc/environment
echo 'https_proxy="$https_proxy"' >> /target/etc/environment
```

### ssh_install

```bash
./scripts/ssh_install.sh $VM_NAME
```

### vm_import/export

```bash
./scripts/vm_export.sh $VM_NAME $VM_OVA
./scripts/vm_import.sh $VM_OVA $VM_DIR
```

### launcher

Démarre la machine virtuelle et ouvre une session SSH :
```bash
./scripts/launcher.sh $VM_NAME
```

|Nom|Valeur par défaut|Description|
|--|--|--|
|VM_USER|zeus||
|VM_SSH_PORT|8022||
|VM_IP|127.0.0.1||


### install_desktop

Créée un fichier .desktop :
```bash
./scripts/install_desktop.sh $VM_NAME
```

|Nom|Valeur par défaut|Description|
|--|--|--|
|VM_ICON|./assets/LVMI.svg||