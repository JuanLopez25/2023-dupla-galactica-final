Class {
	#name : #QueueManager,
	#superclass : #Object,
	#instVars : [
		'max',
		'current',
		'values'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
QueueManager class >> with: anAmount [

	^ self new initializeWith: anAmount
]

{ #category : #'manage turns' }
QueueManager >> current [

	^ values at: current 
]

{ #category : #'manage turns' }
QueueManager >> goNext [

	current := current == max
		           ifTrue: [ 1 ]
		           ifFalse: [ current + 1 ]
]

{ #category : #initialization }
QueueManager >> initializeWith: aValuesCollection [

	values	:= aValuesCollection.
	max := aValuesCollection size.
	current := 1
]

{ #category : #information }
QueueManager >> valuesOnQueue [

	^ max
]
