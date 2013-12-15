#!/bin/sh
describe 'variables'
  var x 1
  describe 'scope'
    var x 2
    it 'reads variables from the enclosing scope'
      expect "$(var x)" to = 2
    end

    it 'writes variables in the local scope'
      var x 3
      expect "$(var x)" to = 3
      var --undef x
      expect "$(var x)" to = 2
    end
  end

  describe 'name'
    it 'follows shell restrictions'
      ERROR=$(var : foo 2>&1)
      expect "$ERROR" to != ""
    end
  end
end
