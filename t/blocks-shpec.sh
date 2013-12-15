#!/bin/sh

describe 'blocks'
  (describe 'hooks'
    my_block() {
        shpec_begin_block my_block
    }

    my_block_enter() {
        MY_BLOCK_ENTERED=entered
    }

    my_block_leave() {
        MY_BLOCK_LEFT=left
    }

    (describe 'entering a block'
      it 'calls the enter hook'
        my_block
          expect "$MY_BLOCK_ENTERED" to = entered
        end
      end
    end)

    (describe 'leaving a block'
      it 'calls the leave hook'
        my_block; end
        expect "$MY_BLOCK_LEFT" to = left
      end
    end)
  end)
end
