# Ansible OSX

Developer Operation Streamline Repo

### Dependencies

* OSX initialize
```sh
make
```

```sh
find . -type f -d 1 -exec 7z a {}-$( date "+%m%d%H%M%Y%S").7z {} \;
find . -type d -d 1 -exec 7z a {}-$( date "+%m%d%H%M%Y%S").7z {} \;
```
