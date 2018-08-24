#!/bin/bash
echo $PATH|rev|cut -d ':' -f 1|rev
 
