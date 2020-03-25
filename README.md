efi-roller
=========

efi-roller is a simple script to help sign EFI images. It creates the needed
keys and helps you keep track of what to sign.

Missing features:
- Key management/replacement
- GPG/Pass integration(?)
- Yubikey(?)

```
Usage:
  efi-roller [COMMAND]

Commands:
  create-keys           Create keys for EFI signatures
  sign FILE...          Sign a file
  sign-all              Sign all enrolled files
  verify FILE...        Verify a file
  verify-esp            Verify all EFI files in ESP
  enroll FILE...        Enroll a file
  disenroll FILE...     Disenroll a file
```

# Dependencies

* efitools
* openssl
* sbsigntools
* util-linux
* asciidoc (make)

# Usage

## Create keys
```
λ » efi-roller create-keys                  
==> Created system GUID 5f6d7954-74fc-4788-ad66-22fba3cba77b
==> Creating keys with size 4096
  -> Platform key...
Generating a RSA private key
.........++++
............................++++
writing new private key to 'PK.key'
-----
Timestamp is 2018-11-24 18:02:51
Authentication Payload size 1401
Signature of size 1992
Signature at: 40
  -> Key Exchange key...
Generating a RSA private key
....................................................................++++
.....................................................................................................++++
writing new private key to 'KEK.key'
-----
Timestamp is 2018-11-24 18:02:52
Authentication Payload size 1403
Signature of size 1992
Signature at: 40
  -> Signature Database key...
Generating a RSA private key
...............................++++
........................++++
writing new private key to 'DB.key'
-----
Timestamp is 2018-11-24 18:02:52
Authentication Payload size 1413
Signature of size 1992
Signature at 40

λ » efi-roller enroll-keys
==> Preparing EFI keys for enrollment
==> Found KeyTool.efi
  -> Moving info /boot/EFI/BOOT/KeyTool.efi and signing...
==> WARNING: /boot/EFI/BOOT/KeyTool.efi is not signed!
  -> Signing /boot/EFI/BOOT/KeyTool.efi
==> WARNING: Keys have been put on /boot. Remember to remove keys after the enrollment!
```

## Sign files

```
λ » efi-roller sign boot/vmlinuz-linux-lts 
  -> Signing /boot/vmlinuz-linux-lts
```

## Verify files

```
λ » efi-roller verify-esp                 
==> Verifying EFI images in /boot...
==> WARNING: /boot/vmlinuz-linuz is not signed!
  -> /boot/vmlinuz-linux-lts is signed!
```

## Enroll files

```
λ » efi-roller enroll /boot/vmlinuz-linux-lts
==> Enrolling /boot/vmlinuz-linux-lts...

λ » efi-roller enroll /boot/vmlinuz-linux
==> Enrolling /boot/vmlinuz-linuz...

λ » efi-roller sign-all                                
==> Signing all enrolled files...
  -> /boot/vmlinuz-linux-lts is signed!
==> WARNING: /boot/vmlinuz-linux is not signed!
  -> Signing /boot/vmlinux-linux

λ » efi-roller verify-esp
==> Verifying EFI images in /boot...
  -> /boot/vmlinuz-linux is signed!
  -> /boot/vmlinuz-linux-lts is signed!
==> All EFI images signed!
```
