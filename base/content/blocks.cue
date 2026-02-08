// PlatoSL Content Contracts: Common Content Blocks
// The data structures CMS collects and developers receive

package content

import "list"

// Card: Title + optional image + optional text
#Card: {
	title!:       string & =~"^.{1,100}$"
	image?:       #Image
	description?: string & =~"^.{0,500}$"
	link?:        string & =~"^https?://.*"
}

// Hero: Heading + optional subheading + optional image + optional CTA
#Hero: {
	heading!:     string & =~"^.{1,100}$"
	subheading?:  string & =~"^.{0,200}$"
	image?:       #Image
	ctaText?:     string & =~"^.{1,30}$"
	ctaLink?:     string & =~"^https?://.*"
}

// Text block with optional image
#TextBlock: {
	heading?:     string & =~"^.{1,100}$"
	text!:        string
	image?:       #Image
	imagePosition?: "left" | "right" | "top" | "bottom"
}

// Gallery: Collection of images
#Gallery: {
	title?:  string
	images!: [...#Image] & list.MinItems(1)
}

// Quote with optional author
#Quote: {
	text!:   string & =~"^.{1,500}$"
	author?: {
		name!:   string & =~"^.{1,50}$"
		title?:  string & =~"^.{0,50}$"
		avatar?: #Image
	}
}

// Call to action
#CTA: {
	text!:        string & =~"^.{1,50}$"
	link!:        string & =~"^https?://.*"
	description?: string & =~"^.{0,200}$"
}

// Export
Card:      #Card
Hero:      #Hero
TextBlock: #TextBlock
Gallery:   #Gallery
Quote:     #Quote
CTA:       #CTA

// Examples
_examples: {
	card: Card & {
		title:       "Featured Article"
		description: "Learn about our latest features"
		image: {
			src: "https://cdn.example.com/featured.jpg"
			alt: "Article preview"
		}
		link: "https://example.com/article"
	}

	hero: Hero & {
		heading:    "Welcome to Our Platform"
		subheading: "Build amazing things"
		image: {
			src: "https://cdn.example.com/hero.jpg"
			alt: "Platform overview"
		}
		ctaText: "Get Started"
		ctaLink: "https://example.com/signup"
	}

	text_with_image: TextBlock & {
		heading: "Our Mission"
		text:    "We help teams collaborate better..."
		image: {
			src: "https://cdn.example.com/mission.jpg"
			alt: "Team collaboration"
		}
		imagePosition: "right"
	}

	gallery: Gallery & {
		title: "Product Gallery"
		images: [
			{
				src: "https://cdn.example.com/product1.jpg"
				alt: "Product front view"
			},
			{
				src: "https://cdn.example.com/product2.jpg"
				alt: "Product side view"
			},
		]
	}

	quote: Quote & {
		text: "This product changed how we work"
		author: {
			name:  "Jane Smith"
			title: "CEO, Acme Corp"
			avatar: {
				src: "https://cdn.example.com/jane.jpg"
				alt: "Jane Smith"
			}
		}
	}

	cta: CTA & {
		text:        "Start Free Trial"
		link:        "https://example.com/trial"
		description: "No credit card required"
	}
}
