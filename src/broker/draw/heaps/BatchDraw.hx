package broker.draw.heaps;

import banker.vector.VectorReference;

abstract BatchDraw(h2d.SpriteBatch) from h2d.SpriteBatch to h2d.SpriteBatch {
	public extern inline function new(texture: Texture) {
		this = new h2d.SpriteBatch(texture.getEntireTile());
	}

	public extern inline function add(sprite: BatchSprite): Void {
		// skip (before == true) instead of this.add(sprite, false);
		final e = sprite.data;
		@:privateAccess @:nullSafety(Off) {
			e.batch = this;
			if (this.first == null) {
				this.first = e;
				this.last = e;
				e.prev = null;
				e.next = null;
			} else {
				final last = this.last;
				last.next = e;
				e.prev = last;
				e.next = null;
				this.last = e;
			}
		}
	}

	@:access(h2d.SpriteBatch)
	public extern inline function remove(sprite: BatchSprite): Void {
		this.delete(sprite); // sprite must belong to this batch
	}

	public function addElements(sprites: VectorReference<BatchSprite>, endIndex: UInt): Void
		for (i in 0...endIndex) add(sprites[i]);

	public function removeElements(sprites: VectorReference<BatchSprite>, endIndex: UInt): Void
		for (i in 0...endIndex) remove(sprites[i]);
}
