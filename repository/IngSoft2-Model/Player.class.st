Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'color',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
Player class >> with: aSpaceship [

	^ self new initializeWith: aSpaceship
]

{ #category : #sort }
Player >> aheadOf: aPlayer [

	^ aPlayer lap < position lap or:
		  (position lap = aPlayer lap and: position box > aPlayer box)
]

{ #category : #information }
Player >> box [

	^ position box
]

{ #category : #information }
Player >> color [

	^ color
]

{ #category : #initialization }
Player >> initializeWith: aColor [

	color := aColor.
	position := Position create.
]

{ #category : #information }
Player >> lap [ 

	^ position lap.
]

{ #category : #'position control' }
Player >> move: aValue andUpdateLap: aLength [
	
	position move: aValue.
	self updateLap: aLength
]

{ #category : #'position control' }
Player >> moveToTheStart [
	
	position move: (self box * -1) + 1.
]

{ #category : #information }
Player >> updateLap: aLength [

	position box  > aLength ifTrue: [ 
		position moveForwardLapsWithLength: aLength ].

	position box <= 0 ifFalse: [ ^ self ].
		position moveBackwardsLapsWithLength: aLength
]
