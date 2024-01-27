Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Information }
RedoCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard isHolder: holder ]
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
RedoCard >> holder: aHolder [

	holder := aHolder
]

{ #category : #Information }
RedoCard >> isEmpty [
	^false.
]

{ #category : #Information }
RedoCard >> isHolder: aColorPlayer [

	^ holder = aColorPlayer
]

{ #category : #Information }
RedoCard >> isPermanent [

	^ false
]

{ #category : #Information }
RedoCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
