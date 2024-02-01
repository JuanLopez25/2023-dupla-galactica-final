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

{ #category : #creation }
MoonWalkBox >> duplicate [

	^ self class with: effectValue.
]

{ #category : #effect }
MoonWalkBox >> effect: aPlayer in: aGame [

	aGame moveEveryone: effectValue except: aPlayer.
]

{ #category : #initialization }
MoonWalkBox >> initializeWith: aValue [

	effectValue := aValue.
]
