import MillenniumAudit.Core
namespace MillenniumAudit.Millennium.BSD
structure Closure where
  PrimitiveHypotheses : Prop
  CriticalBridge : Prop
  Target : Prop
  primitive_to_bridge : PrimitiveHypotheses → CriticalBridge
  bridge_to_target : CriticalBridge → Target

theorem conditional (M : Closure) (h : M.PrimitiveHypotheses) : M.Target :=
  M.bridge_to_target (M.primitive_to_bridge h)
end MillenniumAudit.Millennium.BSD
