Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Instance creation' }
RedoCard class >> create [
	^self new intializeWith.
]

{ #category : #Information }
RedoCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Initialization }
RedoCard >> applyCardUsing: cardManager at: aGame [

	(cardManager lastCardPlay selectTarget: target)
		applyCardUsing: cardManager
		at: aGame
]

{ #category : #Information }
RedoCard >> haveEffect [

	^ false
]

{ #category : #Information }
RedoCard >> holder [

	^ holder
]

{ #category : #Initialization }
RedoCard >> intializeWith [
	holder:= EmptyPlayer new.
	target:= EmptyPlayer new.
]

{ #category : #Information }
RedoCard >> isEmpty [
	^false.
]

{ #category : #Information }
RedoCard >> isPermanent [

	^ false
]

{ #category : #Information }
RedoCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #Information }
RedoCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
