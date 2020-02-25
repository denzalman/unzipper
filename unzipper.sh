#!/bin/bash

function unzipper {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: unzipper [<file>.<rar|bz2|tgz|gz|tar|tbz2|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|zip>]"
 else
    for f in "$@"
    do
      if [ -f "$f" ] ; then
          case "${f%,}" in
            *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                                7z x ./"$f"        ;;
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                                tar xvf "$f"       ;;
            *.cso)              ciso 0 ./"$f" ./"$f.iso" && extract $f.iso && \rm -f $f ;;
            *.lzma)             unlzma ./"$f"      ;;
            *.bz2)              bunzip2 ./"$f"     ;;
            *.cbr|*.rar)        unrar x -ad ./"$f" ;;
            *.gz)               gunzip ./"$f"      ;;
            *.cbz|*.epub|*.zip) unzip ./"$f"       ;;
            *.z)                uncompress ./"$f"  ;;
            *.xz)               unxz ./"$f"        ;;
            *.exe)              cabextract ./"$f"  ;;
            *.cpio)             cpio -id < ./"$f"  ;;
            *.cba|*.ace)        unace x ./"$f"     ;;
            *.zpaq)             zpaq x ./"$f"      ;;
            *.arc)              arc e ./"$f"       ;;
            *)  echo "unzipper: '$f' - unknown archive format"
               return 1;;
          esac
      else
                echo "unzipper: '$f' - file not found"
          return 1
      fi
    done
fi
}
