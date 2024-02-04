Class {
	#name : #Creator,
	#superclass : #Object,
	#instVars : [
		'objects'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Creator class >> use: anObjectProbabilitiesCollection [

	(anObjectProbabilitiesCollection sum: [ :objectProbability | 
		 objectProbability probability ]) = 100 ifFalse: [ 
		Error signal: 'The sum of probabilities must be 100' ].
	^ self new initializeUse: anObjectProbabilitiesCollection
]

{ #category : #creation }
Creator >> create: aNumberOfObjects [

	| objectCreated |
	objectCreated := OrderedCollection new.
	aNumberOfObjects timesRepeat: [ 
		objectCreated addLast: (self oneRandomObject) ].
	^ objectCreated
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
