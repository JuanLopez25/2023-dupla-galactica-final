Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'lengthMeasure'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Intance creation' }
Board class >> with: aBoxCollection measure: aLengthMeasure [

	aLengthMeasure nominalValue <= 0 ifTrue: [ 
		Error signal: 'Cannot create a game a negative parsec amount' ].
	aBoxCollection size < 4 ifTrue: [ 
		Error signal: 'Cannot create a board with that value' ].
	^ self new initializeWith: aBoxCollection measure: aLengthMeasure
]

{ #category : #information }
Board >> boxes [

	^ boxes size
]

{ #category : #'box effect' }
Board >> effectAt: aPosition In: aGame [

	(boxes at: aPosition) effect: aGame 
]

{ #category : #initialization }
Board >> initializeWith: aBoxCollection measure: aLengthMeasure [

	lengthMeasure := aLengthMeasure.
	boxes := aBoxCollection
]

{ #category : #information }
Board >> lightYears [

	^ lengthMeasure lightYears
]

{ #category : #information }
Board >> parsecs [

	^ lengthMeasure parsecs
]
