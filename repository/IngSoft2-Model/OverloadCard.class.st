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

{ #category : #Information }
OverloadCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Effect }
OverloadCard >> applyCardUsing: cardManager at: aGame [

	
	aGame isValidPlayer: target.
	cardManager activeCard: (self class create newHolder: target).
]

{ #category : #Effect }
OverloadCard >> applyEffect [

	^ -2
]

{ #category : #Information }
OverloadCard >> haveEffect [

	^ true
]

{ #category : #Information }
OverloadCard >> holder [

	^ holder
]

{ #category : #Initialization }
OverloadCard >> initializeCreate [
	holder:= EmptyObject new.
	target:= EmptyObject new.
]

{ #category : #Information }
OverloadCard >> isEmpty [
	^ false.
]

{ #category : #Information }
OverloadCard >> isPermanent [

	^ true
]

{ #category : #Information }
OverloadCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #Information }
OverloadCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
