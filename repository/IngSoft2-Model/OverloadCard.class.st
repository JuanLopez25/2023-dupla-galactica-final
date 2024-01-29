Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
OverloadCard class >> create [
	^ self new initializeCreate.
]

{ #category : #information }
OverloadCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #effect }
OverloadCard >> applyCardUsing: cardManager at: aGame [

	
	aGame isPlaying: target.
	cardManager activeCard: ((self class create) selectTarget: target)
]

{ #category : #effect }
OverloadCard >> applyEffect [

	^ -2
]

{ #category : #information }
OverloadCard >> hasEffect [

	^ true
]

{ #category : #information }
OverloadCard >> holder [

	^ holder
]

{ #category : #initialization }
OverloadCard >> initializeCreate [
	holder:= EmptyObject new.
	target:= EmptyObject new.
]

{ #category : #information }
OverloadCard >> isEmpty [

	^ false
]

{ #category : #information }
OverloadCard >> isPermanent [

	^ true
]

{ #category : #information }
OverloadCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #information }
OverloadCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]

{ #category : #information }
OverloadCard >> target [

	^ target
]
