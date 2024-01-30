Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'faces',
		'valueManager'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'Instance creation' }
LoadedDie class >> with: aValuesCollection [

	aValuesCollection
		detect: [ :value | value < 0 ]
		ifFound: [ 
		Error signal: 'Cannot create with negative values at faces' ].
	aValuesCollection size < 3 ifTrue: [ 
		Error signal: 'Cannot create with faces less than 3' ].
	^ self new initializeWith: aValuesCollection
]

{ #category : #Initialization }
LoadedDie >> initializeWith: aValue [

	valueManager := QueueManager with: aValue
]

{ #category : #Information }
LoadedDie >> numberOffaces [

	^ (valueManager valuesOnQueue).
]

{ #category : #Throw }
LoadedDie >> throw [

	| value |
	value := valueManager current.
	valueManager goNext.
	^ value
]
