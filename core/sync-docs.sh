#!/bin/bash

# Paths
DOC_SRC="/Volumes/Grid/Projects/MCPi/core/docs/"
DOC_DEST="/Volumes/Grid/Projects/MCPi/docs/docs/"

# Sync private docs to public-facing repo
rsync -av --delete "$DOC_SRC" "$DOC_DEST"

# Commit and push changes to public docs repo
cd "/Volumes/Grid/Projects/MCPi/docs"
git add .
git commit -m "Sync updated docs from MCPi-core"
git push
