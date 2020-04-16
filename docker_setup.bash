# -----------------------------------------------------------
#
# Setup for docker usage
#
# -----------------------------------------------------------

alias d-asciidoctor='run --rm  --volume="$PWD:/documents" asciidoctor/docker-asciidoctor:latest asciidoctor'

alias d-jekyll='docker run --rm --volume="$PWD:/srv/jekyll" boekhoff/jekyll-asciidoc:latest jekyll'
