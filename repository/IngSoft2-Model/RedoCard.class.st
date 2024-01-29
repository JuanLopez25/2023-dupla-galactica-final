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

{ #category : #information }
RedoCard >> = aCard [

	(aCard isKindOf: self class)
		ifTrue: [ ^ aCard holder = holder ]
		ifFalse: [ ^ false ]
]

{ #category : #initialization }
RedoCard >> applyCardUsing: cardManager at: aGame [

	cardManager lastCardPlay isEmpty
		ifFalse: [ 
			((cardManager lastCardPlay newHolder: self) selectTarget: target)
				applyCardUsing: cardManager
				at: aGame ]
		ifTrue: [ 
			Error signal:
				'Redo card cannot be played because there are no cards that have been played before' ]
]

{ #category : #information }
RedoCard >> hasEffect [

	^ false
]

{ #category : #information }
RedoCard >> holder [

	^ holder
]

{ #category : #initialization }
RedoCard >> intializeWith [

	holder := EmptyObject new.
	target := EmptyObject new.
]

{ #category : #information }
RedoCard >> isEmpty [

	^ false
]

{ #category : #information }
RedoCard >> isPermanent [

	^ false
]

{ #category : #information }
RedoCard >> newHolder: aHolder [

	holder := aHolder
]

{ #category : #information }
RedoCard >> selectTarget: aNewTarget [

	target:= aNewTarget.
]
