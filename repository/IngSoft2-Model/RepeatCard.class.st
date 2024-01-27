Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Information }
RepeatCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard isHolder: holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Effect }
RepeatCard >> applyCardUsing: cardManager at: aGame [

	aGame isValidPlayer: target.
	aGame repeatEffectTo: target.
]

{ #category : #Information }
RepeatCard >> haveEffect [

	^ true
]

{ #category : #Information }
RepeatCard >> holder: aHolder [

	holder := aHolder
]

{ #category : #Information }
RepeatCard >> isEmpty [
	^false.
]

{ #category : #Information }
RepeatCard >> isHolder: aColorPlayer [

	^ holder = aColorPlayer
]

{ #category : #Information }
RepeatCard >> isPermanent [

	^ false
]

{ #category : #Information }
RepeatCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
