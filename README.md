# secret - yet another formatter for pass

## Installation
### Dependencies
secret depends on `pass`, `jq` and `yq`, install them first! 
(TODO: link to dependencies, or just add install command lines here)

```
git clone git@github.com:johantiden/secret.git

# Adds secret/bin to PATH
secret/install-bashrc.sh
#OR
secret/install-zshrc.sh
```



## Usage
`secret` uses `pass` to store secrets. You have to first have an active `pass` environment. 

```
pass init
```

Then add a new entry using. This will interactively ask you for credentials strongly recommended!
```
secret add hello-secret
```

You can also insert all arguments at once (use with care!)
```
secret add hello-secret2 myuser mypassword
```

Get your secrets by calling `secret` with the path of the pass file and the key of the field e.g.

```
$ secret hello-secret2 pass
mypassword
$ secret hello-secret2 user
myuser
```

## File format
The whole reason for `secret` to exist is to get a standardised format across the `pass` repo.

Files are structured with the first line being the password. This is to allow interoperability with other tools.
Line 2-x is a yml file which specifies key: value freely. `secret` helps you to always add a password and a "user" field.
From line 2 and on, any yml-compliant data can be added (using `pass edit`) 

TODO: Add a simple helper to add fields

You can fetch the whole file using `pass` directly.
```
$ secret add hello-secret2 myuser mypassword
$ pass hello-secret2
mypassword
user: myuser
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