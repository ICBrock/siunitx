#!/usr/bin/env texlua

-- Build script for "siunitx" files

-- Identify the bundle and module
bundle = ""
module = "siunitx"

-- Release a TDS-style zip
packtdszip = true

-- Typeset only the .tex files
typesetfiles = {"*.tex"}

-- Shorten the tagging list
tagfiles = {"siunitx.dtx"}

-- Source files cover those for rollback
sourcefiles =
  {
    "siunitx.dtx",
    "siunitx.ins",
    "siunitx.tex",
    "siunitx-abbreviation.cfg",
    "siunitx-abbreviation.dtx",
    "siunitx-angle.dtx",
    "siunitx-binary.cfg",
    "siunitx-binary.dtx",
    "siunitx-code.tex",
    "siunitx-command.dtx",
    "siunitx-complex.dtx",
    "siunitx-compound.dtx",
    "siunitx-emulation.dtx",
    "siunitx-locale.dtx",
    "siunitx-number.dtx",
    "siunitx-print.dtx",
    "siunitx-quantity.dtx",
    "siunitx-symbol.dtx",
    "siunitx-table.dtx",
    "siunitx-unit.dtx",
    "siunitx-v2.sty",
    "siunitx-version-1.cfg"
  }
-- Whilst we also need to install .cfg files
installfiles = {"*.cfg", "*.sty"}

-- ASCII mangling is not useful for us
asciiengines = { }

-- Detail how to set the version automatically
function update_tag(file,content,tagname,tagdate)
  tagname = string.gsub(tagname, "^v", "")
  content = string.gsub(content,
    "\\DeclareCurrentRelease%{%}%{[^}]+%}",
    "\\DeclareCurrentRelease{}{" .. tagdate .. "}"
    )
  return string.gsub(content,
    "\n\\ProvidesExplPackage %{siunitx%} %{[^}]+%} %{[^}]+%}\n",
    "\n\\ProvidesExplPackage {siunitx} {"
      .. tagdate .. "} {" .. tagname .. "}\n")
end

function tag_hook(tagname)
  os.execute('git commit -a -m "Step tag"')
  os.execute('git tag -a -m "" ' .. tagname)
end

