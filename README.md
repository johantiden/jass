# jass - [json](https://stedolan.github.io/jq/) [pass](https://www.passwordstore.org/)
Utility to get nicely formatted pass files


## File format
The whole reason for `jass`' existence is to help get a standardised format across the `pass` repo.

Files are structured with the first line being the password. This is to allow interoperability with other tools.
Line 2 and below is formatted as json which specifies key/values. Note that the password should also be put in the json object.
`jass` helps you to always insert a password and an empty json object.
From line 2 and on, any json-compliant data can be added (using `pass edit pass-name`) or by using `jass put pass-name KEY VALUE `


You can fetch the whole file using `pass` directly. 
Notice the first line _and_ the json having the pass:
```
$ pass hello-secret
mypassword
{
  "pass": "mypassword",
  "user": "johantiden",
  "url": "http://example.com"
}
```

Or fetch specific values using `secret`
```
$ pass anotherentry
anotherpassword
user: anotheruser
url: http://anotherurl.example.com
$ secret anotherentry url
http://anotherurl.example.com
```


## Getting started
### Dependencies
jass depends on
[pass](https://www.passwordstore.org/) and
[jq](https://stedolan.github.io/jq/)
install them first!

This project is not meant to replace either jq nor pass. It is in fact highly encouraged to use them together with jass.

### Installation
```
git clone git@github.com:johantiden/secret.git
```
Add secret/bin to PATH, run:
```
# bash
secret/install-bashrc.sh
# zsh
secret/install-zshrc.sh
```

`jass` uses `pass` to store secrets. You have to first have an active [pass environment](https://www.passwordstore.org/).

```
pass init
```

## Usage
Using jass is similar to using pass. Most commands require a `pass-name`. 

### Insert
This will interactively ask you for a password. This will replace any existing object without warning!
```
$ jass insert hello-secret
pass: *********
```

### Put
Put more data into the same pass entry
```
jass put hello-secret user johantiden
jass put hello-secret url "http://example.com"
```

### Get
Get your secrets by calling `jass` with the `pass-name`.
and optionally a jq-selector. Any parameters after the `pass-name` will be considered arguments to `jq`.


```
$ jass hello-secret
{
  "pass": "mypassword",
  "user": "johantiden",
  "url": "http://example.com"
}
```

Use jq to fetch separate fields:
```
$ jass hello-secret | jq -r .pass
mypassword
```
or use some sugar for the above
```
$ jass hello-secret .pass
mypassword
```

You can fetch multiple fields at once if you want:
```
$ jass hello-secret ".url, .user" 
http://example.com
johantiden
```

