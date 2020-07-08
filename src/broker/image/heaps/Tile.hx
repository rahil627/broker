package broker.image.heaps;

import broker.color.ArgbColor;

@:notNull
abstract Tile(h2d.Tile) from h2d.Tile to h2d.Tile {
	/**
		Creates a new `Tile` instance from `image`.
		Available only `#if heaps`.
	**/
	public static extern inline function fromImage(image: hxd.res.Image): Tile
		return image.toTile();

	/**
		Creates a new `Tile` instance from `color`.
	**/
	public static extern inline function fromColor(color: ArgbColor, width: UInt, height: UInt): Tile
		return h2d.Tile.fromColor(color.getRGB().int(), width, height, color.getAlpha().float());

	public var width(get, never): UInt;
	public var height(get, never): UInt;

	/**
		@return Sub-tile from `this` as a new `Tile` instance.
	**/
	public extern inline function getSubTile(
		x: UInt,
		y: UInt,
		width: UInt,
		height: UInt
	): Tile
		return this.sub(x, y, width, height);

	/**
		@return A new `Tile` instance with the center of the tile as its origin point.
	**/
	public extern inline function toCentered(): Tile
		return this.center();

	extern inline function get_width()
		return Floats.toInt(this.width);

	extern inline function get_height()
		return Floats.toInt(this.height);
}
