Class {
	#name : #RedoCard,
	#superclass : #Object,
	#instVars : [
		'holder',
		'target',
		'copying'
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

	cardManager lastCardPlay isEmpty
		ifFalse: [ 
			((cardManager lastCardPlay newHolder: self) selectTarget: target)
				applyCardUsing: cardManager
				at: aGame ]
		ifTrue: [ 
			Error signal:
				'Redo card cannot be played because there are no cards that have been played before' ]
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
	holder:= EmptyObject new.
	target:= EmptyObject new.
	copying := EmptyObject new.
]

{ #category : #Information }
RedoCard >> isEmpty [

	^ false
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
