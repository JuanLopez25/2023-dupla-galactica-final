Class {
	#name : #ObjectProbability,
	#superclass : #Object,
	#instVars : [
		'probability',
		'object'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
ObjectProbability class >> using: aBox withChance: aProbability [

	^ self new initializeUsing: aBox withChance: aProbability
]

{ #category : #initialization }
ObjectProbability >> initializeUsing: anObject withChance: aProbability [

	object := anObject.
	probability := aProbability
]

{ #category : #information }
ObjectProbability >> object [

	^ object
]

{ #category : #information }
ObjectProbability >> probability [

	^ probability
]
