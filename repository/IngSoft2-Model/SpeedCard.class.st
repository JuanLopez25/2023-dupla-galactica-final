Class {
	#name : #SpeedCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Information }
SpeedCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard isHolder: holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Effect }
SpeedCard >> applyCardUsing: cardManager at: aGame [

	aGame isValidPlayer: target.
	cardManager activeCard: ((self class new )holder: target).
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
SpeedCard >> holder: aHolder [

	holder := aHolder
]

{ #category : #Information }
SpeedCard >> isEmpty [
	^false.
]

{ #category : #Information }
SpeedCard >> isHolder: aColorPlayer [

	^ holder = aColorPlayer
]

{ #category : #Information }
SpeedCard >> isPermanent [

	^ true
]

{ #category : #Initialization }
SpeedCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
