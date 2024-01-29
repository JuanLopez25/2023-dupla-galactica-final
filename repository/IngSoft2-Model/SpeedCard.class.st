Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Intance creation' }
SpeedCard class >> create [
	^ self new initializeCreate.
]

{ #category : #information }
SpeedCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #effect }
SpeedCard >> applyCardUsing: cardManager at: aGame [

	aGame isPlaying: target.
	cardManager activeCard:
		((self class create newHolder: holder) selectTarget: target)
]

{ #category : #effect }
SpeedCard >> applyEffect [

	^ 1
]

{ #category : #information }
SpeedCard >> hasEffect [

	^ true
]

{ #category : #effect }
SpeedCard >> holder [

	^ holder
]

{ #category : #initialization }
SpeedCard >> initializeCreate [

	holder := EmptyObject new.
	target := EmptyObject new
]

{ #category : #information }
SpeedCard >> isEmpty [

	^ false
]

{ #category : #information }
SpeedCard >> isPermanent [

	^ true
]

{ #category : #effect }
SpeedCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #initialization }
SpeedCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]

{ #category : #information }
SpeedCard >> target [

	^ target
]
