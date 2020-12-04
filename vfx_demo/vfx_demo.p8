pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
//#include debug.lua ==========
#include debug.lua

//#include core.lua ===========
#include core.lua

//#include vec2.lua ===========
#include vec2.lua

//#include value.lua ==========
#include value.lua

-->8
//#include main.lua ===========
#include main.lua

-->8
//#include particle.lua =======
#include particle.lua

//#include emitter.lua ========
#include emitter.lua

//#include trail.lua ==========
#include trail.lua

//#include effect.lua =========
#include effect.lua

-->8
//#include draw_helpers.lua ===
#include draw_helpers.lua

//#include palette.lua ========
#include palette.lua

//#include fake_blending.lua ==
#include fake_blending.lua

//#include bloom.lua ==========
#include bloom.lua

-->8
//#include page_basic.lua =====
#include page_basic.lua

//#include page_curve.lua =====
#include page_curve.lua

//#include page_emitter.lua ===
#include page_emitter.lua

//#include page_uv.lua ========
#include page_uv.lua

//#include page_palette.lua ===
#include page_palette.lua

//#include page_trail.lua =====
#include page_trail.lua

//#include page.lua ===========
#include page.lua

__gfx__
0000000000aaaa0066666666000000000000000070000000c7ccccc7c00000cc0800000000070000055055500bbb000000000000000000000000000000000000
000000000aaaaaa0600000060000000080000880d5000000777ccc77c00044cc008800000005000000505550b000bb0000000000000000000000000000000000
00700700aa1aa1aa600000060080b00000090880d050000077ccc447c304044c808988000057500000055500000000b000000000000000000000000000000000
00077000aaaaaaaa600000060000000000909000d0050000cccc44440cc444cc00889800750505700a05000a00bb000b00000000000000000000000000000000
00077000aaaaaaaa6000000600c0700000090000d0005000ccc44444ccc666cc0889a88000050000000080000b00b00b00000000000000000000000000000000
00700700a1aaaa1a666666660000000000000900d000050033334444cc66640c089aa98000070000a0089800b0000bb000000000000000000000000000000000
000000000a1111a000066000000000000a009090d000005011133344c611110c089aa980005050000089a800b00b000000000000000000000000000000000000
0000000000aaaa000066660000000000000009007dddddd733111333cc00cccc0899998000707000000880000bb0000000000000000000000000000000000000
000000000008b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000c70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000060606000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000008bc8bc8b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000011100000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000001121110000000000000000000000003322ddd554400000000000000000000000000000000000000000000000000
00000000000000000000000000000000000122222211100000000000000000000003322ddd554400000000000000000000000000000000000000000000000000
000000000000000000000000000100000012332222221000000000000000000000009900000cc000000000000000000000000000000000000000000000000000
000000000000000000000000001110011112333333232100000000000000000000009900000cc000000000000000000000000000000000000000000000000000
00000000000000001111110000121012222223334432210000000000000000000000088000bb0000000000000000000000000000000000000000000000000000
00000000000000001222111000122123322222334432210000000000000000000000088000bb0000000000000000000000000000000000000000000000000000
0000000000000000233222211122222222222333332221100000000000000000000000770aa00000000000000000000000000000000000000000000000000000
0000000000000000333222211223322222223333333321100000000000000000000000770aa00000000000000000000000000000000000000000000000000000
00000000000000013432222112223222222333333334211000000000000000000000000666000000000000000000000000000000000000000000000000000000
00000000000000013432222222232222223345443344311110000000000000000000000666000000000000000000000000000000000000000000000000000000
00000000000000013322222233222222233466665344321110000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000011112222222222222222333466665344311110000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000001111111223222222223333566665334321110000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000011112221111233222222223333566663333322110000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000012222221112222222222334433445553333332211110000000000000000000000000000000000000000000000000000000000000000000000000000
00000001122222222222222222323456654333442233333321111110000000000000000000000000000000000000000000000000000000000000000000000000
00000001123333333222222322345666666543332333333321211221000000000000000000000000000000000000000000000000000000000000000000000000
00000002223444333222222223346666666643322333333322222223210000000000000000000000000000000000000000000000000000000000000000000000
00000012222444344322222223346666666653322233333322224444321100000000000000000000000000000000000000000000000000000000000000000000
00001112232333344432222233346666656554332222333322234555432100000000000000000000000000000000000000000000000000000000000000000000
00001222223333344432222334345655545544443222334322334555432100000000000000000000000000000000000000000000000000000000000000000000
00001222223333343332222233345443334444454322234322233444432100000000000000000000000000000000000000000000000000000000000000000000
00011232223333333333222223345432233345555432223222223444433100000000000000000000000000000000000000000000000000000000000000000000
00011233322333333333333223344322222345555422222222222233333100000000000000000000000000000000000000000000000000000000000000000000
00012233332233333333344433333222222244445322223222222233333210000000000000000000000000000000000000000000000000000000000000000000
00012233322223332333455433332222222233333322233322222223432100000000000000000000000000000000000000000000000000000000000000000000
00001222222222232234665543222112222222223232223322222223333200000000000000000000000000000000000000000000000000000000000000000000
00001222111222333334656653222222222112222332233232232323333200000000000000000000000000000000000000000000000000000000000000000000
00001222111122222344456653233222222112222333222322333232223210000000000000000000000000000000000000000000000000000000000000000000
00001222111112223344456663233222223111222333222222333332222210000000000000000000000000000000000000000000000000000000000000000000
00000111111122223334566664233211221111122322222222233432211000000000000000000000000000000000000000000000000000000000000000000000
00000112222122223333466654222212211111122222222223333332210000000000000000000000000000000000000000000000000000000000000000000000
00000122222222222223455553222122211222222222112233333322100000000000000000000000000000000000000000000000000000000000000000000000
00000112221222212222354442222222222222222222122333222221100000000000000000000000000000000000000000000000000000000000000000000000
00000011221111111222344532222223322222222222223333333321100000000000000000000000000000000000000000000000000000000000000000000000
00000011122111001222234432222333332222222222233333333221000000000000000000000000000000000000000000000000000000000000000000000000
00000001112111111222233322223343333332222233443333332221000000000000000000000000000000000000000000000000000000000000000000000000
00000000112111112332222221222344333333223333444444432221000000000000000000000000000000000000000000000000000000000000000000000000
00000001112211123342222222223345433333223344344445433221000000000000000000000000000000000000000000000000000000000000000000000000
00000001112211223332222222334444433333333433334434432210000000000000000000000000000000000000000000000000000000000000000000000000
00000001112212222222222223344444443443333332223343332110000000000000000000000000000000000000000000000000000000000000000000000000
00000000011222222222232223344455554654322222222333322100000000000000000000000000000000000000000000000000000000000000000000000000
00000000001222222222232233334655666654322122222332221000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000222222222332233344666666654211112222222100000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000122233333332233446666666543211112222222100000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001122333333322223456556655432211111122232210000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000112222222222223344444433322221101122222110000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000012222222322233333333333322222111112211100000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000011222223233333344333444322332110111111000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000001122222223433344444454332332111112111000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000122222223333333344455432232111112100000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000112222222222222334444332221111211100000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000112221111121222224433222111001111100000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000112111111110011112322221100000011100000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000011000110000012101111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
