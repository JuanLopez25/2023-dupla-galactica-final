Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'box',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
Position class >> create [

	^ self new initializeCreate
]

{ #category : #information }
Position >> box [

	^ box
]

{ #category : #initialization }
Position >> initializeCreate [

	box := 1.
	lap := 0
]

{ #category : #information }
Position >> lap [

	^ lap
]

{ #category : #movement }
Position >> move: aValue [

	box := box + aValue
]

{ #category : #movement }
Position >> moveBackwardsLapsWithLength: aLength [

	lap := lap - (box abs // aLength + 1).
	lap < 0
		ifTrue: [ 
			lap := 0.
			box := 1 ]
		ifFalse: [ 
			box := aLength - box abs <= 0
				       ifTrue: [ aLength - (box abs % aLength) ]
				       ifFalse: [ aLength - box abs ] ]
]

{ #category : #movement }
Position >> moveForwardLapsWithLength: aLength [

	lap := lap + (box // aLength).
	box := box % aLength
]
