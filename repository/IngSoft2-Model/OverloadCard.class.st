Class {
	#name : #OverloadCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Information }
OverloadCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard isHolder:holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Effect }
OverloadCard >> applyCardUsing: cardManager at: aGame [

	
	aGame isValidPlayer: target.
	cardManager activeCard: (self class new holder: target).
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
OverloadCard >> holder: aHolder [

	holder := aHolder
]

{ #category : #Information }
OverloadCard >> isEmpty [
	^ false.
]

{ #category : #Information }
OverloadCard >> isHolder: aColorPlayer [

	^ holder = aColorPlayer
]

{ #category : #Information }
OverloadCard >> isPermanent [

	^ true
]

{ #category : #Information }
OverloadCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
