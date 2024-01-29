Class {
	#name : #RepeatCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'Intance creation' }
RepeatCard class >> create [
	^self new intializeWith.
]

{ #category : #Information }
RepeatCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #Effect }
RepeatCard >> applyCardUsing: cardManager at: aGame [

	aGame isPlaying: target.
	aGame repeatEffectTo: target.
	cardManager discard: self.
]

{ #category : #Information }
RepeatCard >> haveEffect [

	^ true
]

{ #category : #Information }
RepeatCard >> holder [

	^ holder
]

{ #category : #Initialization }
RepeatCard >> intializeWith [
	holder:= EmptyObject new.
	target:= EmptyObject new.
]

{ #category : #Information }
RepeatCard >> isEmpty [
	^false.
]

{ #category : #Information }
RepeatCard >> isPermanent [

	^ false
]

{ #category : #Information }
RepeatCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #Information }
RepeatCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
