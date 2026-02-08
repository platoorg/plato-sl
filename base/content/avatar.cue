// PlatoSL Content Contract: Avatar
// The data structure CMS collects and developers receive

package content

#Avatar: {
	// Profile image
	image!: #Image

	// Optional display name (short)
	name?: string & =~"^.{1,30}$"
}

// Export
Avatar: #Avatar

// Examples
_examples: {
	with_name: Avatar & {
		image: {
			src: "https://cdn.example.com/avatars/jane.jpg"
			alt: "Jane Doe"
		}
		name: "Jane"
	}

	image_only: Avatar & {
		image: {
			src: "https://cdn.example.com/avatars/user.jpg"
			alt: "User avatar"
		}
	}
}
