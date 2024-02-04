Class {
	#name : #Creator,
	#superclass : #Object,
	#instVars : [
		'objects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Creator class >> use: aBoxesProbabilitiesCollection [

	(aBoxesProbabilitiesCollection sum: [ :boxProbability | 
		 boxProbability probability ]) = 100 ifFalse: [ 
		Error signal: 'The sum of probabilities must be 100' ].
	^ self new initializeUse: aBoxesProbabilitiesCollection
]

{ #category : #creation }
Creator >> create: aNumberOfBoxes [

	| boxesCreated |
	boxesCreated := OrderedCollection new.
	aNumberOfBoxes timesRepeat: [ 
		boxesCreated addLast: (self oneRandomObject) ].
	^ boxesCreated
]

{ #category : #initialization }
Creator >> initializeUse: anObjectProbabilityCollection [

	objects := anObjectProbabilityCollection
]

{ #category : #creation }
Creator >> oneRandomObject [

	| aRandomValue sum|
	sum := 0.
	aRandomValue := 100 atRandom.
	^ ((objects detect: [ :object |
		sum := sum + object probability.
		aRandomValue <= sum]) object) deepCopy.
]
