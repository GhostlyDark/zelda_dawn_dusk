//Zelda 64 Dawn & Dusk - NTSC 1.0 ROM Patch
//By LuigiBlood

//Uses ARM9 bass

arch n64.cpu
endian msb

include "N64.INC"
include "N64_GFX.INC"

output "../CZLJ_DawnDusk.z64", create

insert "../CZLJ00_D.z64"

print "Patching Zelda ROM (NTSC 1.0)...\n"

macro seek(n) {
	origin {n}
}

macro seekDisk(n) {
	origin {n}
}

//Patch Macro
macro n64dd_PatchCopy(addr, size) {
	origin {addr}
}

macro n64dd_PatchFill(addr, size, fill) {
	origin {addr}
    fill {size}, {fill}
}

macro n64dd_PatchEnd() {
    //Do nothing
}

macro n64dd_ImportFile(addr, name, file) {
    seek({addr})
    insert {name},{file}
}

macro n64dd_SceneEntry(name, scenestart, titlestart, unk0, renderinit, dd) {
    seek(DDHOOK_SCENETABLE + (0x14 * {dd}))

	dw ({scenestart}), ({scenestart} + {scenestart}.size)
	if {titlestart} != 0 {
		dw ({titlestart}), ({titlestart} + {titlestart}.size)
	} else {
		dw 0,0
	}
	db ({unk0}), ({renderinit}), ({dd}), 0x00
}

macro n64dd_RoomEntry(roomstart) {
	dw ({roomstart}), ({roomstart} + {roomstart}.size)
}

constant DDHOOK_DMADATA(0x00007430)
macro n64dd_DMAEntry(id, file) {
	pushvar origin
	seek(DDHOOK_DMADATA + ({id} * 0x10))
	dw ({file}), ({file} + {file}.size)
	dw ({file}), 0
	pullvar origin
}

constant FREE_SPACE(0x347E040)

//Define constants for all patches
constant DDHOOK_CODE0(0x00A87000)
constant DDHOOK_N64DD(0x00B8AD30)
constant DDHOOK_OVL_EN_MAG(0x00E6C0D0)

constant DDHOOK_OVL_PLAYER_ACTOR(0x00BCDB70)
constant DDHOOK_OVL_KALEIDO_SCOPE(0x00BB11E0)
constant DDHOOK_OVL_EFFECT_SS_STICK(0x00EAD0F0)
constant DDHOOK_OVL_ITEM_SHIELD(0x00DB1F40)
constant DDHOOK_GAMEPLAY_KEEP(0x00F03000)
constant DDHOOK_ICON_ITEM_STATIC(0x007BD000)
constant DDHOOK_ICON_ITEM_24_STATIC(0x00846000)
constant DDHOOK_OVL_EN_OSSAN(0x00C6C5E0)
constant DDHOOK_OBJECT_PO_COMPOSER(0x0191C000)
constant DDHOOK_OBJECT_HIDAN_OBJECTS(0x01125000)
constant DDHOOK_OBJECT_BDOOR(0x01484000)
constant DDHOOK_OBJECT_MIZU_OBJECTS(0x0122C000)
constant DDHOOK_OBJECT_ICE_OBJECTS(0x012A2000)
constant DDHOOK_OBJECT_SPOT02_OBJECTS(0x013FD000)
constant DDHOOK_PARAMETER_STATIC(0x01A3C000)
constant DDHOOK_OBJECT_SD(0x01389000)
constant DDHOOK_OBJECT_FD2(0x0142E000)
constant DDHOOK_OVL_EN_FZ(0x00DFC970)
constant DDHOOK_OVL_BG_VB_SIMA(0x00D16CC0)
constant DDHOOK_OVL_EN_WF(0x00ED8060)
constant DDHOOK_OVL_BOSS_FD(0x00CE65F0)
constant DDHOOK_OVL_BOSS_FD2(0x00D04790)
constant DDHOOK_OVL_BG_HIDAN_CURTAIN(0x00C81950)
constant DDHOOK_OBJECT_BOX(0x00FEB000)

n64dd_ImportFile(0x00FBE000, DDHOOK_OBJECT_LINK_CHILD, "../object/object_link_child.bin")

//ovl_En_Cs (Spooky)
//values from 0xBF00B4 in code, first two bytes +0x0001
origin $00E61782
dh 0x0602

origin $00E61786
dh 0xCC68

//ovl_En_Heishi2 (Keaton)
//values from 0xBF00AC in code, first two bytes +0x0001
origin $00D1C532
dh 0x0602

origin $00D1C536
dh 0xD108

//ovl_En_Mm (Bunny)
//values from 0xBF00B8 in code, first two bytes +0x0001
origin $00E51582
dh 0x0602

origin $00E51586
dh 0xF290

//---Setup Link (Child) Optimized (by CrookedPoe)
include "../patch/misc-opti_link_child.0.patch"

//Force use Hylian Shield like Adult Link
n64dd_PatchCopy((DDHOOK_CODE0 + 0x68400), 4)
nop
