Class {
	#name : #HyperJumpBox,
	#superclass : #Object,
	#instVars : [
		'parsecs',
		'parsecManager'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
HyperJumpBox class >> with: aParsecCollection [

	aParsecCollection isEmpty ifTrue: [ 
		Error signal: 'There are no values to use in the hyper jump box' ].
	^ self new initializeWith: aParsecCollection
]

{ #category : #information }
HyperJumpBox >> currentValue [

	^ parsecManager current
]

{ #category : #effect }
HyperJumpBox >> effect: aPlayer in: aGame [

	aGame move: aPlayer amount: self currentValue parsecs nominalValue
		// (aGame parsecs nominalValue // aGame boxes).

	parsecManager goNext
]

{ #category : #initialization }
HyperJumpBox >> initializeWith: aParsecCollection [

	aParsecCollection sort: [ :value1 :value2 | 
		value2 parsecs nominalValue > value1 parsecs nominalValue ].
	parsecs := aParsecCollection.
	parsecManager := QueueManager with: parsecs
]
