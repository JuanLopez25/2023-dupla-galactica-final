Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
Die class >> with: aValue [

	aValue < 3 ifTrue: [ 
		Error signal:
			'Cannot create with negative values at faces or less than 2 faces' ].
	^ self new initializeWith: aValue
]

{ #category : #information }
Die >> faces [

	^ faces
]

{ #category : #initialization }
Die >> initializeWith: aValue [

	faces := aValue
]

{ #category : #throw }
Die >> throw [

	^ faces atRandom
]
