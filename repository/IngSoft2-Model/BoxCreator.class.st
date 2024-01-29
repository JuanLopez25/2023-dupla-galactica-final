Class {
	#name : #BoxCreator,
	#superclass : #Object,
	#instVars : [
		'boxes',
		'probabilities'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
BoxCreator class >> use: aBoxesProbabilitiesCollection [

	(aBoxesProbabilitiesCollection sum: [ :boxProbability | boxProbability probability ]) = 100 ifFalse: [Error signal:
		'The sum of probabilities must be 100'].
	^ self new initializeUse: aBoxesProbabilitiesCollection
]

{ #category : #creation }
BoxCreator >> create: aNumberOfBoxes [

	| boxesCreated |
	boxesCreated := OrderedCollection new.
	aNumberOfBoxes timesRepeat: [ 
		boxesCreated addLast: (self oneRandomBoxOf) ].
	^ boxesCreated
]

{ #category : #initialization }
BoxCreator >> initializeUse: aBoxesCollection [

	boxes := aBoxesCollection
]

{ #category : #creation }
BoxCreator >> oneRandomBoxOf [

	| aRandomValue sum|
	sum := 0.
	aRandomValue := 100 atRandom.
	^ (boxes detect: [ :box |
		sum := sum + box probability.
		aRandomValue <= sum]) box.
]
