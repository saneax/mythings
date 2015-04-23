sanjayu
=======

Personal Setting and scripts
ssh keys - decrypt and encrypt steps
```bash
tar czvf - .ssh | gpg -e > ssh.tar.gz.pgp
gpg -d ssh.tar.gz.pgp > ssh.tar.gz
```
