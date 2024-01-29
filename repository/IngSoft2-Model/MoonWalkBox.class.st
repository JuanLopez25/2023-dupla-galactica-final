Class {
	#name : #MoonWalkBox,
	#superclass : #Object,
	#instVars : [
		'effectValue'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
MoonWalkBox class >> with: aValue [

	^ self new initializeWith: aValue
]

{ #category : #effect }
MoonWalkBox >> effect: aGame [

	aGame moveOthers: effectValue
]

{ #category : #initialization }
MoonWalkBox >> initializeWith: aValue [

	effectValue := aValue.
]
