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

{ #category : #Information }
SpeedCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Effect }
SpeedCard >> applyCardUsing: cardManager at: aGame [

	aGame isPlaying: target.
	cardManager activeCard:
		((self class create newHolder: holder) selectTarget: target)
]

{ #category : #Effect }
SpeedCard >> applyEffect [

	^ 1
]

{ #category : #Information }
SpeedCard >> haveEffect [

	^ true
]

{ #category : #Effect }
SpeedCard >> holder [

	^ holder
]

{ #category : #Initialization }
SpeedCard >> initializeCreate [
	holder:= EmptyObject new.
	target:= EmptyObject new.
]

{ #category : #Information }
SpeedCard >> isEmpty [
	^false.
]

{ #category : #Information }
SpeedCard >> isPermanent [

	^ true
]

{ #category : #Effect }
SpeedCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #Initialization }
SpeedCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]

{ #category : #Information }
SpeedCard >> target [

	^ target
]
