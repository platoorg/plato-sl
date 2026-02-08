// PlatoSL Content Contract: Image
// The data structure CMS collects and developers receive

package content

#Image: {
	// URL to image file
	src!: string & =~"^https?://.*\\.(jpg|jpeg|png|gif|webp|svg)$"

	// Alt text for accessibility
	alt!: string
}

// Export
Image: #Image

// Example
_example: Image & {
	src: "https://cdn.example.com/photo.jpg"
	alt: "Mountain landscape"
}
