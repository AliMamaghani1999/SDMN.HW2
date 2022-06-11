import os
import sys



def builddir():
    i=0
    while 1:
        try:
            os.makedirs("roots/"+str(i))
            os.system("tar -zxf ubuntu-focal-oci-amd64-root.tar.gz -C roots/"+str(i))
            print("roots/"+str(i))
            break
        except:
            i=i+1

builddir()