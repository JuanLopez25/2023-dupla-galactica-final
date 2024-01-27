Class {
	#name : #CancellationCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Information }
CancellationCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard isHolder:holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Effect }
CancellationCard >> applyCardUsing: cardManager at: aGame [

	cardManager desactivate: target
]

{ #category : #Information }
CancellationCard >> haveEffect [

	^ true
]

{ #category : #Information }
CancellationCard >> holder: aHolder [

	holder := aHolder
]

{ #category : #Information }
CancellationCard >> isEmpty [
	^false.
]

{ #category : #Information }
CancellationCard >> isHolder: aColorPlayer [

	^ holder = aColorPlayer
]

{ #category : #Information }
CancellationCard >> isPermanent [

	^ false
]

{ #category : #Information }
CancellationCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
