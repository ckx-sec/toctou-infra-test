#!/bin/sh
echo "CB_GITSOURCE_RESOLVE_TEST"
echo "CONTENT_MARKER=$(cat main.tf | grep 'value =' | head -1)"
