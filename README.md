sanjayu
=======

Personal Setting and scripts
ssh keys - decrypt and encrypt steps
```bash
tar czvf - .ssh | gpg -e > ssh.tar.gz.pgp
gpg -d ssh.tar.gz.pgp > ssh.tar.gz

```
Documents and confidential pdf's
```
cd ~/Documents; find  ./ -maxdepth 1 -type f -print0 | tar -czvf - --exclude='*.gz' -T - | gpg -e >  .pdf/pdf.tar.gz.gpg
cd ~/pdf; find  ./ -maxdepth 1 -type f -print0 | tar -czvf - --exclude='*.gz' -T - | gpg -e >  .documents/documents.tar.gz.gpg
```
