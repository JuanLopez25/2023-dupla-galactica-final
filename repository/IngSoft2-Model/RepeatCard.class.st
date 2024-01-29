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

{ #category : #information }
RepeatCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #effect }
RepeatCard >> applyCardUsing: cardManager at: aGame [

	aGame isPlaying: target.
	aGame repeatEffectTo: target.
	cardManager discard: self.
]

{ #category : #information }
RepeatCard >> hasEffect [

	^ true
]

{ #category : #information }
RepeatCard >> holder [

	^ holder
]

{ #category : #initialization }
RepeatCard >> intializeWith [

	holder := EmptyObject new.
	target := EmptyObject new
]

{ #category : #information }
RepeatCard >> isEmpty [

	^ false
]

{ #category : #information }
RepeatCard >> isPermanent [

	^ false
]

{ #category : #information }
RepeatCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #information }
RepeatCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
