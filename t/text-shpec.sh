#!/bin/sh
describe 'text'
  describe 'prefixing text'
    it 'works with single lines'
      expect "$(echo a | shpec_prefix_with :)" to = ":a"
    end

    (it 'works with multiple lines'
      EXPECTED=$(printf ":a\n:b\n")
      expect "$(printf "a\nb\n" | shpec_prefix_with :)" \
          to = "$EXPECTED"
    end)

    (it 'works with empty lines'
      EXPECTED=$(printf ":\n:b\n")
      expect "$(printf "\nb\n" | shpec_prefix_with :)" \
          to = "$EXPECTED"
    end)

    (it 'works without newline terminated input'
      EXPECTED=$(printf ":a\n")
      expect "$(printf a | shpec_prefix_with :)" \
          to = "$EXPECTED"
    end)
  end

  describe 'indentation'
    (it 'idents using SHPEC_INDENT_STRING and SHPEC_LEVEL'
      PREFIX=$(SHPEC_LEVEL=2 SHPEC_INDENT_STRING=. shpec_indent_prefix 2)
      expect "$PREFIX" to = "."
    end)

    (it 'indents all lines'
      EXPECTED=$(printf ".a\n.\n.b")
      expect "$(SHPEC_LEVEL=2; SHPEC_INDENT_STRING=.; printf "a\n\nb\n" | shpec_indent)" \
          to = "$EXPECTED"
    end)
  end
end
