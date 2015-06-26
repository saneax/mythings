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
=======
```bash
cd ~/Documents; find  ./ -maxdepth 1 -type f -print0 | tar -czvf - --exclude='*.gz' -T - | gpg -e >  .pdf/pdf.tar.gz.gpg
cd ~/pdf; find  ./ -maxdepth 1 -type f -print0 | tar -czvf - --exclude='*.gz' -T - | gpg -e >  .documents/documents.tar.gz.gpg
```

some explanation for my own reference above :)
=============================================

```bash
find ./ -maxdepth 1 -type f -print0
```
Finds within the local path all files and prints in a NULL terminated list, with exclude you can mention files to be excluded.

```bash
tar -czvf - --exclude='*.gz' -T -
```
The abov is interesting 'czvf' is common for archiving, the - (hyphen) next is for streaming it out (STDOUT)rather than writing it to a file. The -T is for taking the argument list in NULL separated format, the next hyphen is to take it from STDIN

```bash
gpg -e > somefile.tar.gz.gpg
```
Write to a file after encrypting it.

Now we will do the reverse
==========================
```bash
gpg -d somefile.tar.gz.gpg | tar zxvf - -C /some/path
```
decrypt, (|) pass it to tar to (-C) some path
